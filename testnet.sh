KEYSTORE="$HOME/.dapp/testnet/8545/keystore"
rm -rf "$KEYSTORE"
(
    while [ ! -f "$HOME/.dapp/testnet/8545/config/account" ] || [ ! -d "$KEYSTORE" ]; do
        sleep 1s
    done
    . testenv.sh
    dapp create PaperfaxIndex | tail -n 1 > contract.txt
) &
dapp testnet --accounts 5
