package util

import "log"

func ErrCheck(err error) {
	if err != nil {
		log.Println(err)
	}
}
