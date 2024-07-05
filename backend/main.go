package main

import (
	"context"
	"encoding/json"
	"net"
	"net/http"
	"os"
	"os/signal"

	"github.com/sirupsen/logrus"
)

func main() {
	ctx, cancel := signal.NotifyContext(context.Background(), os.Interrupt, os.Kill)
	defer cancel()

	log := logrus.New().WithField("component", "main")
	if err := run(ctx, log); err != nil {
		log.WithError(err).Error("running main program")
		os.Exit(1)
	}
}

func run(ctx context.Context, log logrus.FieldLogger) error {
	l, err := net.Listen("tcp", ":8080")
	if err != nil {
		return err
	}
	s := &http.Server{
		Handler: http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			if err := json.NewEncoder(w).Encode(products); err != nil {
				log.WithError(err).Error("encoding products")
				w.Write([]byte("internal server error"))
				w.WriteHeader(http.StatusInternalServerError)
			}
		}),
	}

	log.WithField("addr", l.Addr()).Info("listening")
	go s.Serve(l)

	<-ctx.Done()

	return nil
}
