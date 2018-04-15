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
    
    struct Collection {
        string name;
        string[] songIpfsAddresses;
        uint price;
        bool isValid;
    }
    
    struct Song {
        string name;
        uint price;
        bool isValid;
    }
    
    mapping(string => Song) songs;
    mapping(string => Collection) collections;
    
    string[] songList;
    string[] collectionList;
    
    function Artist(address _owner) public {
        owner = _owner;
        factory = msg.sender;
    }
    
    function createSong(string _ipfsAddress, string _name, uint _price) public {
        if (songs[_ipfsAddress].isValid) {
            return;
        }
        
        var song = songs[_ipfsAddress];
        song.name = _name;
        song.price = _price;
        song.isValid = true;
        
        songList.push(_ipfsAddress) -1;
    }
    
    function createCollection(string _name, uint _price) public {
        if (collections[_name].isValid) {
            return;
        }
        
        var collection = collections[_name];
        collection.name = _name;
        collection.price = _price;
        
        collectionList.push(_name) -1;
    }
    
    function addSongToCollection(string _songIpfs, string _collectionName) public {
        collections[_collectionName].songIpfsAddresses.push(_songIpfs) -1;
    }
    
    /*
    function getSongs() public view returns (string[]) {
        return songList;
    }
    
    function getSong(string _ipfsAddress) public view returns(string, uint) {
        return (songs[_ipfsAddress].name, songs[_ipfsAddress].price);
    }
    
    function getCollections() public view returns (string[]) {
        return collectionList;
    }
    
    function getCollection(string _name) public view returns(string, string[], uint) {
        return (collections[_name].name, collections[_name].songIpfsAddresses, collections[_name].price);
    }*/
}