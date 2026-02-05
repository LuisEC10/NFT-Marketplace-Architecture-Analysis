# NFT-Marketplace-Architecture-Analysis
-------------------------------------------------------
Este es un repositorio de white-box reverse engineering sobre el código realizado en el repositorio (privado) nft-marketplace-fullstackweb3.

-> Señalaré las funciones de cada archivo dentro de la carpeta "src" de tal forma que sea útil para la construcción de mi propia plataforma de certificados ERC-721.

-------------------------------------------------------
## Librería que se usan:
#### Openzeppelin Contracts
[openzeppelin-contracts](https://github.com/OpenZeppelin/openzeppelin-contracts)
```bash
forge install OpenZeppelin/openzeppelin-contracts
```
-------------------------------------------------------
**Mock USDC -> MockUSDC.sol**
Podría crear mi propia moneda en base a ERC20, de tal forma que se entrega una cantidad inicial al deployer del contrato, y no se gasta dinero real.


-------------------------------------------------------
Comandos que pueden servir:

> Para señalar donde se encuentran las librerías con respecto al foundry.toml
```bash
forge remappings > remappings.txt
```
