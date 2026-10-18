package main

import (
	"log"
	"net/http"
)

func main() {
	// Serve static content (index.html, vivus.min.js, frame*.svg) from ./html on port 8080.
	log.Fatal(http.ListenAndServe(":8080", http.FileServer(http.Dir("./html"))))
}
