<template>
    <div class="bg-white p-6 rounded shadow">
        <h2 class="bal-all-list text-2xl font-semibold mb-4">
            Current Balances
        </h2>

        <ul class="ul-list list-disc mb-4">
            <li v-for="b in balances" :key="b.id" class="toaster-m">
                ID {{ b.id }} — Amount:
                <span class="bal-lis-am inline-flex items-center">
                    <IconCurrencyNaira class="w-5 h-5 mr-1" />
                    {{ b.amount }}
                </span>
            </li>
        </ul>

        <div class="imcre-div flex space-x-4">
            <button
                class="increminate-bal px-4 py-2 bg-blue-600 text-white rounded"
                @click="incrementBalances"
                :disabled="loading"
            >
                {{ loading ? "Incrementing…" : "Increment Balances" }}
            </button>

            <button
                class="increminate-bal px-4 py-2 bg-red-500 text-white rounded"
                @click="clearBalances"
            >
                <div class="del-bal">
                    <IconTrashX class="iccon-del text-[#ffffff]" />
                    <span>Clear All Balances</span>
                </div>
            </button>
        </div>
    </div>
</template>

<script>
import { IconCurrencyNaira, IconTrashX } from "@tabler/icons-vue";

export default {
    name: "BalanceList",
    components: {
        IconCurrencyNaira,
        IconTrashX,
    },
    data() {
        return {
            balances: [],
            loading: false,
        };
    },
    mounted() {
        this.fetchBalances();
    },
    methods: {
        async fetchBalances() {
            try {
                const res = await fetch("/api/balances");
                this.balances = await res.json();
            } catch (err) {
                console.error("Fetch balances error:", err);
            }
        },
        async incrementBalances() {
            this.loading = true;
            try {
                await fetch("/api/balances/increment", { method: "POST" });
                await this.fetchBalances();
            } catch (err) {
                console.error("Increment error:", err);
            } finally {
                this.loading = false;
            }
        },
        async clearBalances() {
            if (!confirm("Delete ALL balances?")) return;
            try {
                await fetch("/api/balances", { method: "DELETE" });
                await this.fetchBalances();
            } catch (err) {
                console.error("Clear balances error:", err);
            }
        },
    },
};
</script>
