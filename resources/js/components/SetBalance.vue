<template>
    <div class="bg-white p-6 rounded shadow">
        <h2 class="bal-all-ini text-2xl font-semibold mb-4">
            Set Initial Balance
        </h2>
        <form @submit.prevent="submit">
            <label class="amounting block mb-2">
                Amount
                <input
                    v-model.number="amount"
                    type="number"
                    min="0"
                    required
                    class="mt-1 block w-full border rounded px-3 py-2"
                />
                <IconCurrencyNaira class="naira w-5 h-5 mr-1" />
            </label>
            <button
                type="submit"
                class="create-bal mt-3 px-4 py-2 bg-green-600 text-white rounded"
            >
                Create Balance
            </button>
        </form>
        <p v-if="message" class="toaster-m mt-3 text-green-700">{{ message }}</p>
    </div>
</template>

<script>
import { IconCurrencyNaira } from "@tabler/icons-vue";

export default {
    name: "SetBalance",
    components: {
        IconCurrencyNaira,
    },

    data() {
        return {
            amount: null,
            message: "",
        };
    },
    methods: {
        async submit() {
            this.message = "";
            try {
                const res = await fetch("/api/balances", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ amount: this.amount }),
                });
                if (!res.ok) throw new Error("Failed");
                const data = await res.json();
                this.message = `Balance Number ${data.id} created: N${data.amount}`;
                this.amount = null;
            } catch (err) {
                console.error(err);
                this.message = "Error creating balance";
            }
        },
    },
};
</script>
