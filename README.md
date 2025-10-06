# 🛒 Flipkart Clone

> **An end-to-end e-commerce platform built with Ruby on Rails during my internship at [Shriffle Technologies, Indore](https://www.shriffle.com/).**
> Implements real-world features such as user authentication, product management, order tracking, and an admin dashboard.

---

## 📌 Table of Contents

* [Project Overview](#project-overview)
* [Features](#features)
* [Tech Stack](#tech-stack)
* [Screenshots](#screenshots)
* [Setup & Installation](#setup--installation)
* [Usage Guide](#usage-guide)
* [API Overview](#api-overview)
* [Testing](#testing)
* [Deployment](#deployment)
* [Future Improvements](#future-improvements)
* [License](#license)
* [Contact](#contact)

---

## ✅ Project Overview

This Flipkart Clone project is a fully functional e-commerce web application developed during my internship at **Shriffle Technologies**, Indore.

It includes:

* Customer-facing storefront
* Secure authentication system using **Devise** and **JWT**
* **Admin dashboard** built with **ActiveAdmin**
* Background job processing via **Sidekiq**
* Modern Rails frontend with **Turbo**, **Stimulus**, and **Importmap**
* Image uploads, pagination, charts, and much more

---

## ✨ Features

* 👤 **User Authentication**

  * Registration, login, password reset
  * Token-based auth with `devise-jwt`
* 📦 **Product Catalog**

  * Product browsing, details page, search, pagination
  * Image uploads via `ActiveStorage`
* 🛒 **Shopping Cart & Orders**

  * Add to cart, remove, checkout, order confirmation
* 🛠️ **Admin Panel**

  * Built with `ActiveAdmin`
  * Manage products, categories, orders, users
* 📊 **Dashboards & Charts**

  * Order statistics via `Chartkick` and `Groupdate`
* 📬 **Mailers**

  * Order confirmation & password reset using `ActionMailer` and `Letter Opener`
* 🔁 **Background Jobs**

  * Queue processing with `Sidekiq`
* 💅 **Responsive UI**

  * Mobile-first layout using Bootstrap (via ActiveAdmin theme)

---

## 🧰 Tech Stack

| Layer              | Technology                          |
| ------------------ | ----------------------------------- |
| **Language**       | Ruby 3.0.0                          |
| **Framework**      | Ruby on Rails 7.1.5.2               |
| **Database**       | PostgreSQL                          |
| **Authentication** | Devise, JWT (`devise-jwt`)          |
| **Admin Panel**    | ActiveAdmin                         |
| **Job Queue**      | Sidekiq + Redis                     |
| **Image Uploads**  | ActiveStorage + ImageProcessing     |
| **Charts**         | Chartkick, Groupdate                |
| **Frontend**       | Turbo, Stimulus, Importmap          |
| **Testing**        | RSpec, Capybara, Selenium           |
| **Styling**        | SassC, Bootstrap                    |
| **Other**          | Kaminari, WillPaginate, Web Console |

---

## 🖼️ Screenshots

> (Add screenshots of key pages — home page, product page, admin dashboard, etc.)

---

## ⚙️ Setup & Installation

### 🔧 Requirements

* Ruby `3.0.0`
* Rails `~> 7.1.5.2`
* PostgreSQL
* Redis (for Sidekiq)
* Node.js (if needed for asset builds)

---

### 🔑 Environment Setup

Create a `.env` file (or configure `credentials.yml.enc`) with:

```
DATABASE_URL=postgres://user:password@localhost:5432/flipkart_clone
DEVISE_JWT_SECRET_KEY=your_secure_jwt_secret
REDIS_URL=redis://localhost:6379/0
```

Install dependencies:

```bash
bundle install
rails db:create db:migrate db:seed
```

Start the servers:

```bash
# Web
rails server

# Sidekiq (in separate terminal)
bundle exec sidekiq
```

Access the app at `http://localhost:3000`.

---

## 🛠️ Usage Guide

* Register or login via the homepage
* Browse products and add to cart
* Checkout to place an order
* Admin panel available at `/admin`

  * Default credentials (if seeded):

    ```
    email: admin@example.com  
    password: password
    ```

---

## 🔌 API Overview

This project supports RESTful JSON APIs (ideal for mobile clients).

Sample endpoints:

| Method | Endpoint         | Description       |
| ------ | ---------------- | ----------------- |
| `POST` | `/users/sign_in` | Login and get JWT |
| `POST` | `/users`         | Register          |
| `GET`  | `/products`      | List products     |
| `POST` | `/cart/add`      | Add to cart       |
| `POST` | `/orders`        | Place order       |

(Provide Postman collection or OpenAPI docs if available)

---

## 🧪 Testing

Run tests using:

```bash
bundle exec rspec
```

Includes:

* Unit tests for models
* Feature/system tests using `Capybara` and `Selenium`
* Mocking via `RSpec Mocks`

---

## 🚀 Deployment

This app can be deployed to platforms like:

* **Heroku**
* **Render**
* **DigitalOcean**
* **AWS EC2 / Lightsail**

### Docker (optional)

If containerized:

```bash
docker-compose up --build
```

Ensure Redis and PostgreSQL are configured in `docker-compose.yml`.

---

## 🔮 Future Improvements

* Razorpay / Stripe integration for real payments
* Wishlist / Save for later
* Product reviews & ratings
* Order tracking page with status updates
* Advanced admin analytics dashboard
* 2FA for enhanced security
* Inventory management with alerts
* Progressive Web App (PWA) support

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 🙋‍♂️ Contact

**Aditya Aerpule**
Intern @ Shriffle Technologies
📧 [[adityaaerpule@gmail.com](mailto:adityaaerpule@gmail.com)]
🔗 [GitHub](https://github.com/aadi-insane) | [LinkedIn](https://www.linkedin.com/in/aditya-aerpule-a22062309/)

