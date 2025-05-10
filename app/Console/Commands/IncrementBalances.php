<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Balance;
use App\Models\BalanceIncrement;
use Illuminate\Support\Facades\Log;

class IncrementBalances extends Command
{
    protected $signature = 'balances:increment';
    protected $description = 'Increment all balances by 100';

    public function handle(): void
    {
        $balances = Balance::all();

        foreach ($balances as $balance) {
            $balance->amount += 1000;
            $balance->save();

            BalanceIncrement::create([
            'balance_id'        => $balance->id,
            'amount_changed'    => 1000,
            'resulting_balance' => $balance->amount,
        ]);

            Log::info("[Scheduler] Balance ID {$balance->id} incremented by 100.");
        }

        $this->info('All balances incremented.');
    }
}