use actix_cors::Cors;
use actix_files::Files;
use actix_web::{App, HttpServer};
use actix_web::middleware::Logger;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Log that the API is starting
    println!("📔Static Server can be found at ➡️ http://localhost:5050/static/index.html");
    HttpServer::new(move || {
        // ! Configure CORS
        let cors = Cors::default()
            .allow_any_origin()
            .allow_any_method()
            .allow_any_header()
            .supports_credentials();

        App::new()
            .wrap(cors)
            .wrap(Logger::default())
            .service(Files::new("/static", "./public").show_files_listing())
    })
        .bind(("0.0.0.0", 5050))?
        .run()
        .await
}