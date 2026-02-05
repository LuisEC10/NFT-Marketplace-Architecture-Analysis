// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract CakeNft is ERC721, Ownable {
    error ERC721Metadata__URI_QueryFor_NonExistentToken();
    error CakeNFT__NotOwner();
    error CertificateNft__URI_QueryFor_NonExistentToken();

    // Creación del token ERC-721, que hace referencia y pertenencia al creador
    // del contrato
    constructor() ERC721("Cake NFT", "CN") Ownable(msg.sender) {}

    /*//////////////////////////////////////////////////////////////
                                 TYPES
    //////////////////////////////////////////////////////////////*/


    /*//////////////////////////////////////////////////////////////
                            STATE VARIABLES
    //////////////////////////////////////////////////////////////*/

    uint256 private s_tokenCounter;
    mapping(uint256 tokenId => string imageUri) private s_tokenIdToImageUri;
    
    event CreatedNFT(uint256 indexed tokenId);
    event CertificateMinted(uint256 indexed tokenId, address indexed student);

    // -> crea todo de cero
    // /*//////////////////////////////////////////////////////////////
    //                            FUNCTIONS
    // //////////////////////////////////////////////////////////////*/

    // function bakeCake() public returns (uint256) {
    //     uint256 tokenCounter = s_tokenCounter;

    //     uint256 cakeSeed = uint256(keccak256(abi.encodePacked(
    //             msg.sender, tokenCounter, block.number, block.timestamp
    //         )
    //     ));
    //     string memory cakeSvg = createSvgCakeFromSeed(cakeSeed);
    //     string memory imageUri = svgToImageURI(cakeSvg);

    //     // En este caso, tokenCounter es el TokenID del Token ERC721 solo que
    //     // cada NFT pertenece a una sola dirección, pero con el ID ayuda a identificar
    //     // de qué NFT se trata, y con el _safeMint envíamos el token exacto al
    //     // creador del token
    //     _safeMint(msg.sender, tokenCounter);

    //     s_tokenIdToImageUri[tokenCounter] = imageUri;
    //     emit CreatedNFT(tokenCounter);
    //     s_tokenCounter = s_tokenCounter + 1;
    //     return tokenCounter;
    // }

    /**
     * @dev Función para emitir un certificado.
     * @param student La wallet del alumno.
     * @param _tokenUri El link al JSON en IPFS (ej: "ipfs://QmHas...")
     */
    function mintCertificate(address student, string memory _tokenUri) public onlyOwner {
        uint256 tokenId = s_tokenCounter;

        // 1. Guardar el link ("ipfs://QM...")
        s_tokenIdToImageUri[tokenId] = _tokenUri;

        _safeMint(student, tokenId);

        emit CertificateMinted(tokenId, student);

        s_tokenCounter++;
    }

    /**
     * @dev ESTA ES LA CLAVE. OpenSea llama aquí para saber qué mostrar.
     */
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        // Validación: Si el token no tiene dueño (no existe), revertir.
        if (ownerOf(tokenId) == address(0)) {
            revert CertificateNft__URI_QueryFor_NonExistentToken();
        }
        
        // Simplemente devolvemos la URL que guardamos en el mapping
        return s_tokenIdToImageUri[tokenId];
    }


    /*//////////////////////////////////////////////////////////////
                                GETTERS
    //////////////////////////////////////////////////////////////*/
    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}