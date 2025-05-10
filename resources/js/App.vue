<template>
    <div class="main-div p-6 max-w-3xl mx-auto">
        <div class="top-t">
            <img src="../.././public/favicon.png" alt="" />
            <h1>Account Balance Scheduler</h1>
        </div>

        <!-- Navigation -->
        <nav class="top-but flex space-x-4 mb-6">
            <button
                :class="tab === 'set' ? activeClass : inactiveClass"
                @click="tab = 'set'"
            >
                Set Balance
            </button>
            <button
                :class="tab === 'list' ? activeClass : inactiveClass"
                @click="tab = 'list'"
            >
                Balances
            </button>
            <button
                :class="tab === 'history' ? activeClass : inactiveClass"
                @click="tab = 'history'"
            >
                History
            </button>
        </nav>

        <!-- Dynamic component -->
        <component :is="currentComponent" />
    </div>
</template>

<script>
import SetBalance from "./components/SetBalance.vue";
import BalanceList from "./components/BalanceList.vue";
import IncrementHistory from "./components/IncrementHistory.vue";

export default {
    name: "App",
    data() {
        return {
            tab: "set",
            activeClass: "px-4 py-2 bg-indigo-600 text-white rounded",
            inactiveClass: "px-4 py-2 bg-white text-gray-700 rounded border",
        };
    },
    computed: {
        currentComponent() {
            if (this.tab === "set") return SetBalance;
            if (this.tab === "list") return BalanceList;
            if (this.tab === "history") return IncrementHistory;
        },
    },
};
</script>
