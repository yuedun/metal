package util

import (
	"github.com/astaxie/beego/logs"

	"github.com/go-redis/redis"
)

func ExampleNewClient() {
	client := redis.NewClient(&redis.Options{
		Addr:     "ip:port",
		Password: "", // no password set
		DB:       0,  // use default DB
	})

	pong, err := client.Ping().Result()
	logs.Info(pong, err)
	// Output: PONG <nil>
	err1 := client.Set("key", "value", 0).Err()
	if err1 != nil {
		panic(err)
	}

	val, err := client.Get("key").Result()
	if err != nil {
		panic(err)
	}
	logs.Info("key", val)

	val2, err := client.Get("key2").Result()
	if err == redis.Nil {
		logs.Info("key2 does not exist")
	} else if err != nil {
		panic(err)
	} else {
		logs.Info("key2", val2)
	}
	// Output: key value
	//	// key2 does not exist
}
