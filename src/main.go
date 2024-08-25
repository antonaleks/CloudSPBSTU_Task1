package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"sync"
)

var (
	urlMapping = make(map[int]string)
	mu         sync.Mutex
	nextID     = 1
)

func shortenURLHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodPost {
		originalURL := r.FormValue("url")
		if originalURL == "" {
			http.Error(w, "URL is required", http.StatusBadRequest)
			return
		}

		mu.Lock()
		shortURLID := nextID
		urlMapping[shortURLID] = originalURL
		nextID++
		mu.Unlock()

		shortURL := fmt.Sprintf("http://localhost:8080/%d", shortURLID)
		fmt.Fprintf(w, "Shortened URL: %s\n", shortURL)
		fmt.Printf("INFO Shortened URL: %s\n", shortURL)
	} else {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
	}
}

func redirectHandler(w http.ResponseWriter, r *http.Request) {
	shortURLIDStr := r.URL.Path[1:]
	shortURLID, err := strconv.Atoi(shortURLIDStr)
	if err != nil {
		http.Error(w, "Invalid URL ID", http.StatusBadRequest)
		return
	}

	mu.Lock()
	originalURL, exists := urlMapping[shortURLID]
	mu.Unlock()

	if !exists {
		http.Error(w, "URL not found", http.StatusNotFound)
		return
	}

	http.Redirect(w, r, originalURL, http.StatusPermanentRedirect)
}

func mapHandler(w http.ResponseWriter, r *http.Request) {
	mu.Lock()
	defer mu.Unlock()
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(urlMapping)
}

func updateURLHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodPut {
		shortURLIDStr := r.URL.Path[8:]
		shortURLID, err := strconv.Atoi(shortURLIDStr)
		if err != nil {
			http.Error(w, "Invalid URL ID", http.StatusBadRequest)
			return
		}

		originalURL := r.FormValue("url")
		if originalURL == "" {
			http.Error(w, "URL is required", http.StatusBadRequest)
			return
		}

		mu.Lock()
		defer mu.Unlock()

		if _, exists := urlMapping[shortURLID]; !exists {
			http.Error(w, "URL not found", http.StatusNotFound)
			return
		}

		urlMapping[shortURLID] = originalURL
		fmt.Fprintf(w, "Updated URL for %d to %s\n", shortURLID, originalURL)
		fmt.Printf("INFO Updated URL for %d to %s\n", shortURLID, originalURL)
	} else {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
	}
}

func main() {
	http.HandleFunc("/shorten", shortenURLHandler)
	http.HandleFunc("/", redirectHandler)
	http.HandleFunc("/map", mapHandler)
	http.HandleFunc("/update/", updateURLHandler) // Note the trailing slash for the update handler

	fmt.Println("Starting server on :8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		fmt.Println("Error starting server:", err)
	}
}
