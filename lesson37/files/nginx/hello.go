package main

import (
    "net/http"
    "os"
)

func indexHandler(w http.ResponseWriter, r *http.Request) {
    w.Write([]byte("Hello World from GO!"))
}

func main() {
    port := os.Getenv("PORT")
    if port == "" {
        port = "5000"
    }

    mux := http.NewServeMux()

    mux.HandleFunc("/", indexHandler)
    http.ListenAndServe("127.0.0.1:"+port, mux)
}