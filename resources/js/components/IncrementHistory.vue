<template>
    <div class="bg-white p-6 rounded shadow">
        <h2 class="bal-all-incre text-2xl font-semibold mb-4">
            Increment History
        </h2>

        <button
            class="increminate-bal px-4 py-2 bg-red-500 text-white rounded"
            @click="clearHistory"
        >
            <div class="del-bal">
                <IconTrashX class="iccon-del text-[#ffffff]" />
                <span>Clear All History</span>
            </div>
        </button>

        <div class="history-grid">
            <div v-for="inc in increments" :key="inc.id" class="each-history">
                <h3>When</h3>
                <p>
                    {{ formatDate(inc.created_at) }}
                </p>

                <h3>Balance ID</h3>
                <p>{{ inc.balance_id }}</p>

                <h3>Changed</h3>
                <p>
                    <IconCurrencyNaira class="w-4 h-4 mr-1" />
                    {{ inc.amount_changed }}
                </p>

                <h3>New Balance</h3>
                <p>
                    <IconCurrencyNaira class="w-4 h-4 mr-1" />
                    {{ inc.resulting_balance }}
                </p>
            </div>
        </div>
    </div>
</template>

<script>
import { IconCurrencyNaira, IconTrashX } from "@tabler/icons-vue";

export default {
    name: "IncrementHistory",
    components: {
        IconCurrencyNaira,
        IconTrashX,
    },
    data() {
        return {
            increments: [],
        };
    },
    mounted() {
        this.fetchHistory();
    },
    methods: {
        async fetchHistory() {
            try {
                const res = await fetch("/api/increments");
                this.increments = await res.json();
            } catch (err) {
                console.error("Fetch history error:", err);
            }
        },
        formatDate(dt) {
            return new Date(dt).toLocaleString();
        },
        async clearHistory() {
            if (!confirm("Delete ALL increment history?")) return;
            try {
                await fetch("/api/increments", { method: "DELETE" });
                await this.fetchHistory();
            } catch (err) {
                console.error("Clear history error:", err);
            }
        },
    },
};
</script>
