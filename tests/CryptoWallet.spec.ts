import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import {Builder, toNano} from '@ton/core';
import { CryptoWallet } from '../wrappers/CryptoWallet';
import '@ton/test-utils';



describe('CryptoWallet', () => {
    let blockchain: Blockchain;
    let deployer: SandboxContract<TreasuryContract>;
    let cryptoWallet: SandboxContract<CryptoWallet>;

    beforeEach(async () => {
        blockchain = await Blockchain.create();


        cryptoWallet = blockchain.openContract(await CryptoWallet.fromInit());


        deployer = await blockchain.treasury('deployer');

        const deployResult = await cryptoWallet.send(
            deployer.getSender(),
            {
                value: toNano('0.05'),
            },
            {
                $$type: 'Deploy',
                queryId: 0n,
            }
        );

        expect(deployResult.transactions).toHaveTransaction({
            from: deployer.address,
            to: cryptoWallet.address,
            deploy: true,
            success: true,
        });
    });

    it('should deploy', async () => {
        // the check is done inside beforeEach
        // blockchain and cryptoWallet are ready to use
    });
});
