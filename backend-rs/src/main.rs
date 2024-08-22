use axum::{response::IntoResponse, routing::get, Json, Router};
use serde::{Deserialize, Serialize};

#[tokio::main]
async fn main() {
    println!("Starting server");

    let app = Router::new()
        .route("/", get(root))
        .route("/products", get(products));

    let listener = tokio::net::TcpListener::bind("127.0.0.1:3001")
        .await
        .unwrap();

    println!("listening on {}", listener.local_addr().unwrap());
    axum::serve(listener, app).await.unwrap()
}

async fn root() -> &'static str {
    "Hello, World!"
}

async fn products() -> impl IntoResponse {
    let products = vec![
        Category{
            name: "Skinnprodukter".to_string(),
            products: vec![
                Product{name: "Sengefell".to_string(), price: "7000,- pr kvm + tekstil".to_string(), description: "Fell til enkeltseng. Du kan velge pelsfarge (rase) og om du vil ha åkle eller trykk på fellen. Størrelse ca 1x1,8 meter. Syr også til dobbeltseng. Ring for bestilling! Syr gjerne til gamle åkler også.".to_string()},
            ],
        },
        Category{
            name: "Saueskinn".to_string(),
            products: vec![
                Product{name: "Saueskinn".to_string(), price: "2000,- pr stk".to_string(), description: "Lorem Ipsum etc mer tekst kan komme her".to_string()},
            ],
        },
        Category{
            name: "Toving".to_string(),
            products: vec![
                Product{name: "Ull".to_string(), price: "200,-".to_string(), description: "Lorem Ipsum etc mer tekst kan komme her".to_string()},
            ],
        },
        Category{
            name: "Alpakkagarn".to_string(),
            products: vec![
                Product{name: "Alpakkagarn 1".to_string(), price: "10,- pr g".to_string(), description: "Lorem Ipsum etc mer tekst kan komme her".to_string()},
                Product{name: "Alpakkagarn 2".to_string(), price: "12,- pr g".to_string(), description: "Lorem Ipsum etc mer tekst kan komme her".to_string()},
            ],
        },
        Category{
            name: "Ullundertøy".to_string(),
            products: vec![
                Product{name: "Bokser".to_string(), price: "400,-".to_string(), description: "Lorem Ipsum etc mer tekst kan komme her".to_string()},
                Product{name: "Sokker".to_string(), price: "400,- pr par".to_string(), description: "Lorem Ipsum etc mer tekst kan komme her".to_string()},
            ],
        },
        Category{
            name: "Skinn".to_string(),
            products: vec![
                Product{name: "Kuskinn".to_string(), price: "3000,-".to_string(), description: "Lorem Ipsum etc mer tekst kan komme her".to_string()},
            ],
        },
    ];

    Json(products).into_response()
}

#[derive(Serialize, Deserialize)]
struct Category {
    name: String,
    products: Vec<Product>,
}
#[derive(Serialize, Deserialize)]
struct Product {
    name: String,
    price: String,
    description: String,
}
