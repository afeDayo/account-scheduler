<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BalanceIncrement extends Model
{
    use HasFactory;

    protected $fillable = [
        'balance_id',
        'amount_changed',
        'resulting_balance',
    ];

    public function balance()
    {
        return $this->belongsTo(Balance::class);
    }
}
