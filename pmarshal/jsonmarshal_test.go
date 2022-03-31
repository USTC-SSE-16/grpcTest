package pmarshal

import (
	"encoding/json"
	"fmt"
	"testing"
)

type Stu struct {
	Name  string `json:"jsonname"`
	Age   int
	High  bool
	Sex   string
	Class *Class `json:"jsonclass"`
}

type Class struct {
	Name  string
	Grade int
}

func TestMarshal(t *testing.T) {
	stu := Stu{
		Name: "Stu",
		Age:  12,
		Sex:  "boy",
		High: true,
	}

	cla := new(Class)
	cla.Name = "c1"
	cla.Grade = 5
	stu.Class = cla

	jstu, err := json.Marshal(stu)
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	fmt.Println(string(jstu))
}

func TestMarshal2(t *testing.T) {
	stu := Stu{
		Name: "Stu",
		Age:  12,
		Sex:  "boy",
		High: true,
	}

	cla := new(Class)
	stu.Class = cla
	// here
	cla.Name = "c1"
	cla.Grade = 5

	jstu, err := json.Marshal(stu)
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	fmt.Println(string(jstu))
}

func TestUnMarshal(t *testing.T) {
	stu := Stu{
		Name: "Stu",
		Age:  12,
		Sex:  "boy",
		High: true,
	}

	cla := new(Class)
	stu.Class = cla
	// here
	cla.Name = "c1"
	cla.Grade = 5

	jstu, err := json.Marshal(stu)
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	t.Log(jstu)

	//fmt.Println(string(jstu))
	var s Stu
	if err := json.Unmarshal(jstu, &s); err != nil {
		t.Log(err.Error())
		return
	}
	t.Log(s.Name)
	t.Log(s.Age)
	t.Log(s.Sex)
	t.Log(s.High)
	t.Log(s.Class.Grade)
	t.Log(s.Class.Name)
}
