// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockUSDC is ERC20 {
    // Constructor para crear la moneda que usará el marketplace NFT 
    // Constructor que define el nombre y símbolo.
    // NOTA: Inicialmente el supply es 0. Se debe llamar a 'mint()' después 
    // del despliegue para generar los primeros tokens.
    constructor() ERC20("Mock USDC", "mUSDC") {}

    // Función para "mintear" nuevos tokens de USDC.
    // En un entorno de pruebas, esto permite a los usuarios obtener
    // tokens adicionales para simular compras sin necesidad de dinero real.
    // SECURITY NOTE: Agregar el onlyowner para evitar emitir infinitamente
    function mint(address to, uint256 amount) public returns(bool) {
        _mint(to, amount);
        return true;
    }

    // USDC tiene 6 decimales en lugar de los 18 que es el estándar en ERC20.
    // Por lo tanto, sobreescribo la función decimals() para que devuelva 6.
    // Esto es importante para que las cantidades de USDC se manejen correctamente
    // en el contrato del marketplace.
    function decimals() public pure override returns (uint8) {
        return 6;
    }

}