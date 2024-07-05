package main

type Product struct {
	Name        string `json:"name"`
	Price       string `json:"price"`
	Description string `json:"description"`
}

type Category struct {
	Name     string    `json:"name"`
	Products []Product `json:"products"`
}

var products = []Category{
	{
		Name: "Skinnprodukter",
		Products: []Product{
			{Name: "Sengefell", Price: "7000,- pr kvm + tekstil", Description: "Fell til enkeltseng. Du kan velge pelsfarge (rase) og om du vil ha åkle eller trykk på fellen. Størrelse ca 1x1,8 meter. Syr også til dobbeltseng. Ring for bestilling! Syr gjerne til gamle åkler også."},
		},
	},
	{
		Name: "Saueskinn",
		Products: []Product{
			{Name: "Saueskinn", Price: "2000,- pr stk", Description: "Lorem Ipsum etc mer tekst kan komme her"},
		},
	},
	{
		Name: "Toving",
		Products: []Product{
			{Name: "Ull", Price: "200,-", Description: "Lorem Ipsum etc mer tekst kan komme her"},
		},
	},
	{
		Name: "Alpakkagarn",
		Products: []Product{
			{Name: "Alpakkagarn 1", Price: "10,- pr g", Description: "Lorem Ipsum etc mer tekst kan komme her"},
			{Name: "Alpakkagarn 2", Price: "12,- pr g", Description: "Lorem Ipsum etc mer tekst kan komme her"},
		},
	},
	{
		Name: "Ullundertøy",
		Products: []Product{
			{Name: "Bokser", Price: "400,-", Description: "Lorem Ipsum etc mer tekst kan komme her"},
			{Name: "Sokker", Price: "400,- pr par", Description: "Lorem Ipsum etc mer tekst kan komme her"},
		},
	},
	{
		Name: "Skinn",
		Products: []Product{
			{Name: "Kuskinn", Price: "3000,-", Description: "Lorem Ipsum etc mer tekst kan komme her"},
		},
	},
}
