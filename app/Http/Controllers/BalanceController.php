<?php

namespace App\Http\Controllers;

use App\Models\Balance;
use Illuminate\Http\Request;

class BalanceController extends Controller
{
    public function index()
    {
        return Balance::all();
    }

    /**
     * Store a new balance.
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'amount' => 'required|integer|min:0',
        ]);

        $balance = Balance::create([
            'amount' => $data['amount'],
        ]);

        return response()->json($balance, 201);
    }

    public function incrementAll()
    {
        $balances = Balance::all();

        foreach ($balances as $balance) {
            $balance->amount += 100; // we’ll update to 1000 in the scheduler step
            $balance->save();
        }

        return response()->json(['message' => 'Balances incremented.']);
    }

     public function destroyAll()
{
    \App\Models\Balance::query()->delete();
    return response()->json(null, 204);
}

   
}
