package main

import (
	"io/ioutil"
	"log"
	"os/exec"
	"strconv"
	"strings"
	"time"
)

const (
	TIME_OUT = time.Minute //1分钟不出数据就重启
)

var (
	lastWCount int
	failedTime int
)

func main() {
	for {
		cmd := exec.Command("/usr/bin/wc", "-l", "dht.out")

		outW, err := cmd.StdoutPipe()
		if err != nil {
			log.Println(err.Error())
			continue
		}
		if err := cmd.Start(); err != nil {
			log.Println(err.Error())
			continue
		}
		data, err := ioutil.ReadAll(outW)
		if err != nil {
			log.Println(err.Error())
			continue
		}
		dataStr := string(data)
		strs := strings.Split(dataStr, " ")
		if len(strs) != 2 {
			log.Println("解析出错")
			continue
		}
		wCountStr := strs[0]
		wCount, err := strconv.Atoi(wCountStr)
		if err != nil {
			log.Println(err.Error())
			continue
		}
		if lastWCount == wCount {
			failedTime++
		} else {
			failedTime = 0
		}
		if failedTime >= 1 {
		RETRY:
			log.Println("重启应用")
			cmd := exec.Command("kbpm", "restart", "dht_run.sh")
			if err := cmd.Start(); err != nil {
				log.Println(err.Error())
				goto RETRY
			}
		}
		log.Println("这次WC:", wCount, "  上次WC:", lastWCount, "  失败次数:", failedTime)
		lastWCount = wCount
		time.Sleep(TIME_OUT) //1分钟
	}

}
