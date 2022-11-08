FROM rust:slim AS builder

WORKDIR /app
COPY src src
COPY Cargo.toml .
COPY index.html .
COPY index.scss .

RUN rustup target add wasm32-unknown-unknown && cargo install trunk

RUN trunk build --release --public-url "lemmeknow-frontend" --filehash false

FROM nginx:alpine-1
WORKDIR /usr/share/nginx/html
COPY --from=builder /app/dist .