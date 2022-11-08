FROM rust:slim AS builder

WORKDIR /app
COPY src src
COPY Cargo.toml .
COPY index.html .
COPY index.scss .

RUN rustup target add wasm32-unknown-unknown && cargo install trunk

RUN trunk build --release --filehash false

FROM nginx:1-alpine
WORKDIR /usr/share/nginx/html
COPY --from=builder /app/dist .