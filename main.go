package main

import (
	"hello/src"
	"net/http"
)

func main() {
	src.Hi()
	http.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {
		src.Hi()
		writer.Write([]byte("hi"))
	})
	http.ListenAndServe(":8080", nil)
}
