//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract NFTFlagsMock is ERC721, IERC721Receiver, Ownable {
    using Strings for uint256;

    mapping(address => bool) public allowedMinters;
    uint256 public tokenIdCounter;
    mapping(uint256 => uint256) public tokenIdToChallengeId;
    mapping(address => mapping(uint256 => bool)) public hasMinted;

    event FlagMinted(address indexed minter, uint256 indexed tokenId, uint256 indexed challengeId);

    constructor(address _initialOwner) Ownable(_initialOwner) ERC721("BG-CTF", "CTF") { }

        function mint(address _recipient, uint256 _challengeId) external {
        require(allowedMinters[msg.sender], "Not allowed to mint");
        _mintToken(_recipient, _challengeId);
    }

    function _mintToken(address _recipient, uint256 _challengeId) internal {
        tokenIdCounter++;
        uint256 newTokenId = tokenIdCounter;
        _safeMint(_recipient, newTokenId);
        tokenIdToChallengeId[newTokenId] = _challengeId;
        hasMinted[_recipient][_challengeId] = true;
        emit FlagMinted(_recipient, newTokenId, _challengeId);
    }

    function addAllowedMinter(address minter) external onlyOwner {
        allowedMinters[minter] = true;
    }

    function _toUint256(bytes memory _bytes) internal pure returns (uint256) {
        require(_bytes.length >= 32, "toUint256_outOfBounds");
        uint256 tempUint;

        assembly {
            tempUint := mload(add(_bytes, 0x20))
        }

        return tempUint;
    }
    function onERC721Received(address, address from, uint256 tokenId, bytes calldata data)
        external
        override
        returns (bytes4)
    {
        uint256 anotherTokenId = _toUint256(data);

        require(msg.sender == address(this), "only this contract can call this function!");

        require(ownerOf(anotherTokenId) == from, "Not owner!");

        require(tokenIdToChallengeId[tokenId] == 1, "Not the right token 1!");
        require(tokenIdToChallengeId[anotherTokenId] == 9, "Not the right token 9!");

        _mintToken(from, 10);

        safeTransferFrom(address(this), from, tokenId);

        return this.onERC721Received.selector;
    }

}