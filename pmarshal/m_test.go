package pmarshal

import (
	"encoding/json"
	"testing"
)

func TestJson(t *testing.T) {
	x, _ := json.Marshal([]string{"aaa:123", "bbb:456"})
	//fmt.Println(x)
	t.Log(x)
	var caps []string
	json.Unmarshal(x, &caps)
	//fmt.Println(caps)
	t.Log(caps)
}
