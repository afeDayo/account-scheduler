# Account Balance Increment Scheduler

## Overview

This is a simple full-stack application built using **Laravel 10** and **Vue 3**. The app allows users to set an initial balance, and a scheduled background task increases that balance by **1,000 units every 5 minutes**, recording each increment in a log for easy tracking.

---

## Key Features

-   Set an **initial account balance** using a web form
-   Schedule background job that increments the balance automatically
-   Log each increment with **timestamp, amount, and resulting balance**
-   Display the **history of increments** in a user-friendly format
-   Buttons to manually trigger increment or clear balances/history

---

## Technologies Used

-   Laravel 10
-   Vue 3 (Vite)
-   Tailwind CSS
-   MySQL
-   Laravel Scheduler

---

## Setup Instructions

### 1. Clone the Repository

```
git clone https://github.com/your-username/account-scheduler.git
```

### 2. Install PHP and JS Dependencies

```
composer install
npm install
```

### 3. Create Environment File

Copy `.env.example` to `.env` and update values as needed:

-   Database credentials
-   App URL
-   Mail and queue settings (optional)

```
cp .env.example .env
```

### 4. Generate Application Key

```
php artisan key:generate
```

### 5. Run Migrations and Seeders

This will create the required tables and populate dummy data:

```
php artisan migrate --seed
```

### 6. Compile Frontend Assets

```
npm run dev       # For development
```

### 7. Start the Application

```
php artisan serve
```

The application will be accessible at:

```
http://localhost:8000
```

---

## Laravel Scheduler Setup

To simulate balance increment every 5 minutes:

### 1. Register the Command in `App\Console\Kernel.php`

Make sure the command is scheduled like this:

```php
$schedule->command('balance:increment')->everyFiveMinutes();
```

### 2. Run Laravel Scheduler

To run the scheduled job manually:

```
php artisan schedule:work
```

For production, set up a system-level cron job:

```
* * * * * php /path/to/your/project/artisan schedule:run >> /dev/null 2>&1
```

---

## Frontend Usage

### Set Balance Tab

-   Enter a number and click **Create Balance** to set a new balance.

### Balances Tab

-   See current balances, trigger manual increment, or clear balances.

### History Tab

-   View all increment logs with details like amount and time.
-   Option to clear the entire history.

---

## Important Artisan Commands

-   Migrate database:
    php artisan migrate

    ```

    ```

-   Seed database:
    php artisan db:seed

    ```

    ```

-   Migrate and seed together:
    php artisan migrate --seed

    ```

    ```

-   Run the background job manually:
    php artisan balance:increment

    ```

    ```

-   Serve the Laravel app:
    php artisan serve

    ```

    ```

-   Start the scheduler (for testing locally):
    php artisan schedule:work
    ```

    ```

---

## Deployment Notes

-   Build assets before pushing to production using `npm run build`.
-   Ensure a cron job is set for the scheduler.

---

## License

This project is open-source and free to use under the **MIT License**.