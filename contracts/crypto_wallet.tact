import "@stdlib/deploy";

message Add {
    queryId: Int;
    amount: Int;
}

struct Balances {
    usdtBalance: Int;
    tonBalance: Int;
    profitPerDay: Int;
    dailyProfitRate: Int = 5 / 10;
}

contract CryptoWallet with Deployable {
    balance : Balances;

    init( balance : Balances) {
        self.balance = Balances{
        profitPerDay: 0,
        usdtBalance: 0,
        tonBalance: 0,
        dailyProfitRate: 0
        };
    }

    fun depositUsdt(usdtDeposit: Int): Balances {
        self.balance.usdtBalance = self.balance.usdtBalance + usdtDeposit;
        return self.balance
    }

    fun depositTon(tonDeposit: Int): Balances {
      self.balance.tonBalance = self.balance.tonBalance + tonDeposit;
        return self.balance
    }

    get fun tonBalance(): Int {
        return self.balance.tonBalance
    }

    get fun usdtBalance(): Int {
        return self.balance.usdtBalance
    }

    fun withdrawUsdt(usdtAmount: Int) {
        if (self.balance.usdtBalance > usdtAmount) {
            self.balance.usdtBalance - usdtAmount;
            dump(usdtAmount)
        } else {
            dump("Insuficient Balance")
        }
    }

    fun withdrawTon(tonAmount: Int) {
        if (self.balance.tonBalance > tonAmount) {
            self.balance.tonBalance - tonAmount;
            dump(tonAmount)
        } else {
            dump ("Insuficient Balnace")
        }
    }

    fun dailyPnl() {
        if (self.balance.tonBalance > 30) {
            let rate = self.balance.dailyProfitRate / 100;
            let pnl = self.balance.tonBalance * rate;
            self.balance.profitPerDay = pnl;
            dump(pnl)
        }
    }

    get fun todaysPnl(): Int {
        return self.balance.profitPerDay;
    }

}