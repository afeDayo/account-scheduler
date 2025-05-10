<?php

namespace App\Console;

use App\Console\Commands\IncrementBalances;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    protected function schedule(Schedule $schedule): void
    {
        $schedule->command('balances:increment')->everyFiveMinutes();
    }

    protected $commands = [
        Commands\IncrementBalances::class,
    ];
}
