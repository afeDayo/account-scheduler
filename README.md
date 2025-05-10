#A simple Laravel 10 + Vue 3 application that lets you:#

Set an initial account balance via a web form.

Automatically increment that balance by 1,000 units every 5 minutes (via the Laravel scheduler).

Log each increment (amount, timestamp, resulting balance) in the database.

View balance history in a dedicated Vue component.

Clear all balances or history with one click.

📋 Table of Contents
Features

Requirements

Installation

Environment Setup

Database Migrations & Seeding

Running the Laravel Server & Scheduler

Running the Vue Frontend (Vite)

Using the App

Project Structure

License

🚀 Features
Set Balance tab to create a new balance record

Balances tab to view current balances, increment manually, or clear all

History tab to view all increment log entries, or clear them

Automated scheduler command increment:balances runs every 5 minutes

BalanceIncrement model and balance_increments table store each run

🛠 Requirements
PHP 8.1+

Composer

Node.js (v16+) & npm

MySQL (or other supported database)

[Optional] cron or task scheduler for running Laravel’s scheduled commands

🔧 Installation
Clone the repo

bash
Copy
Edit
git clone https://github.com/your-username/account-scheduler.git
cd account-scheduler
Install PHP dependencies

bash
Copy
Edit
composer install
Install JS dependencies

bash
Copy
Edit
npm install
Initialize Tailwind CSS & Vite
(Already configured—just ensure resources/css/app.css imports Tailwind directives.)

⚙️ Environment Setup
Copy the example environment file:

bash
Copy
Edit
cp .env.example .env
Generate the application key:

bash
Copy
Edit
php artisan key:generate
Configure your .env database settings:

dotenv
Copy
Edit
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=your_database
DB_USERNAME=your_user
DB_PASSWORD=your_password

APP_URL=http://localhost:8000
Optional: If you want to seed demo data, create the database first and configure .env accordingly.

🗄 Database Migrations & Seeding
Run migrations and seed the database:

bash
Copy
Edit
php artisan migrate --seed
This will create:

balances table

balance_increments table

Seed a few demo Balance records via BalanceFactory & BalanceSeeder.

If you ever need to reset everything and reseed:

bash
Copy
Edit
php artisan migrate:refresh --seed
🏃 Running the Laravel Server & Scheduler
Serve Laravel on port 8000:

bash
Copy
Edit
php artisan serve
Schedule worker:
Set up a cron entry (Linux/macOS) to run every minute:

cron
Copy
Edit
* * * * * cd /path/to/account-scheduler && php artisan schedule:run >> /dev/null 2>&1
That will trigger your command IncrementBalances every five minutes, as configured in app/Console/Kernel.php:

php
Copy
Edit
protected function schedule(Schedule $schedule): void
{
    $schedule->command('increment:balances')->everyFiveMinutes();
}
💻 Running the Vue Frontend (Vite)
Compile & watch your assets:

bash
Copy
Edit
npm run dev
Open the Vite dev server (default http://localhost:5173/).
Your Laravel blade template (resources/views/welcome.blade.php) already includes:

blade
Copy
Edit
@vite('resources/css/app.css')
@vite('resources/js/app.js')
So when you visit http://localhost:8000, the Vue SPA will mount into <div id="app"></div>.

🎮 Using the App
Visit http://localhost:8000.

Navigate between tabs:

Set Balance: enter an amount, click Create Balance.

Balances: view all balances, click Increment Balances (manual), or Clear All Balances.

History: view each automatic increment (timestamp, delta, new balance), or Clear All History.

Automated increments will run every 5 minutes if your scheduler is active.

📁 Project Structure
arduino
Copy
Edit
account-scheduler/
├── app/
│   ├── Console/
│   │   └── Commands/IncrementBalances.php
│   ├── Http/
│   │   └── Controllers/
│   │       ├── BalanceController.php
│   │       └── IncrementController.php
│   ├── Models/
│   │   ├── Balance.php
│   │   └── BalanceIncrement.php
├── database/
│   ├── factories/
│   │   └── BalanceFactory.php
│   ├── migrations/
│   │   ├── xxxx_create_balances_table.php
│   │   └── xxxx_create_balance_increments_table.php
│   └── seeders/
│       ├── BalanceSeeder.php
│       └── DatabaseSeeder.php
├── resources/
│   ├── css/
│   │   └── app.css          ← imports Tailwind directives
│   └── js/
│       ├── app.js           ← Vue app bootstrap
│       ├── App.vue          ← main component & navigation
│       └── components/
│           ├── SetBalance.vue
│           ├── BalanceList.vue
│           └── IncrementHistory.vue
├── routes/
│   └── api.php              ← API routes for balances & increments
├── vite.config.js
├── webpack.mix.js           ← optional if using Mix
└── README.md                ← you are here
📝 License
This project is open-sourced under the MIT license. Feel free to fork and customize!