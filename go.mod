module metal

go 1.14

require (
	github.com/PuerkitoBio/goquery v1.5.1
	github.com/StackExchange/wmi v0.0.0-20190523213315-cbe66965904d // indirect
	github.com/astaxie/beego v1.12.1
	github.com/go-ole/go-ole v1.2.4 // indirect
	github.com/go-redis/redis v6.15.8+incompatible
	github.com/go-sql-driver/mysql v1.5.0
	github.com/golang/protobuf v1.4.2 // indirect
	github.com/gomarkdown/markdown v0.0.0-20200609195525-3f9352745725
	github.com/microcosm-cc/bluemonday v1.0.3
	github.com/onsi/ginkgo v1.14.0 // indirect
	github.com/qiniu/api.v7 v7.2.5+incompatible
	github.com/qiniu/x v7.0.8+incompatible // indirect
	github.com/robfig/cron v1.2.0
	github.com/russross/blackfriday v2.0.0+incompatible
	github.com/sclevine/agouti v3.0.0+incompatible // indirect
	github.com/shiena/ansicolor v0.0.0-20151119151921-a422bbe96644 // indirect
	github.com/shirou/gopsutil v2.20.6+incompatible
	github.com/shurcooL/sanitized_anchor_name v1.0.0 // indirect
	github.com/stretchr/testify v1.6.1 // indirect
	golang.org/x/crypto v0.0.0-20200709230013-948cd5f35899 // indirect
	golang.org/x/text v0.3.3 // indirect
	qiniupkg.com/x v7.0.8+incompatible // indirect
)

replace (
	golang.org/x/crypto => github.com/golang/crypto v0.0.0-20190313024323-a1f597ede03a
	golang.org/x/image => github.com/golang/image v0.0.0-20191214001246-9130b4cfad52
	golang.org/x/net => github.com/golang/net v0.0.0-20190318221613-d196dffd7c2b
	golang.org/x/text => github.com/golang/text v0.3.2
	golang.org/x/tools => github.com/golang/tools v0.0.0-20190529010454-aa71c3f32488
)
