pragma solidity ^0.4.0;

contract ArtistFactory {
    struct ArtistInfo {
        string name;
        address contractAddress;
        bool isValid;
    }
    
    mapping(address => ArtistInfo) artists; 
    address[] public artistList;

    function createArtist(string _name) public {
        if (artists[msg.sender].isValid) {
            return;
        }
        
        var artist = artists[msg.sender];
        artist.name = _name;
        artist.contractAddress = new Artist(msg.sender);
        artist.isValid = true;
        artistList.push(msg.sender) -1;
    }
    
    function getArtists() view public returns(address[]) {
        return artistList;
    }
    
    function getArtist(address _address) view public returns (string, address) {
        return (artists[_address].name, artists[_address].contractAddress);
    }
}

contract Artist {
    address owner;
    address factory;
    
    struct Song {
        string name;
        address artist;
        uint price;
        string publicKey;
        string privateKey;
    }
    
    function Artist(address _owner) {
        owner = _owner;
        factory = msg.sender;
    }
}



/*
contract BeatBlocks {
    struct Artist {
        string name;
        bool valid;
    }
    
    
    
    mapping(string => Song) songs;
    mapping(address => Artist) artists;
    
    string[] songList;

    function BeatBlocks() public {
        
    }
    
    function createArtist(string _name) {
        var artist = artists[msg.sender];
        if (artist.valid) {
            return;
        }
        
        artist.name = _name;
        artist.valid = true;
    }
    
    function publishSong(string _ipfsAddress, string _name, uint _price, string _publicKey, string _privateKey) public {
        var song = songs[_ipfsAddress];
        song.name = _name;
        song.artist = msg.sender;
        song.price = _price;
        song.publicKey = _publicKey;
        song.privateKey = _privateKey;
    }

}*/