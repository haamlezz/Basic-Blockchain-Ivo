// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

// declare contract name
contract FarmToFork {
    // Enum to represent the various stages of the product
    enum Stage {
        Produced,
        Packed,
        Shipped,
        Received,
        Sold
    }

    // Struct to store product details
    struct Product {
        uint256 id;
        string name;
        string farmer;
        string factory;
        string shop;
        /////Exercise 1: Declare customer variable

        uint256 producedDate;
        uint256 packedDate;
        uint256 shippedDate;
        uint256 receivedDate;
        /////Exercise 2: Declare soldDate variable

        Stage currentStage;
    }

    // Mapping to store products by their hashed ID
    mapping(bytes32 => Product) public products;

    // Event to log the product update
    event ProductUpdated(bytes32 productId, Stage newStage);

    // Function to generate a unique product ID
    function generateProductId(
        string memory _name,
        string memory _farmer
    ) internal view returns (bytes32) {
        return
            keccak256(
                abi.encodePacked(_name, _farmer, block.timestamp, msg.sender)
            );
    }

    // Function to add a new product
    function addProduct(string memory _name, string memory _farmer) public {
        bytes32 productId = generateProductId(_name, _farmer);

        products[productId] = Product({
            id: uint256(productId),
            name: _name,
            farmer: _farmer,
            factory: "",
            shop: "",
            producedDate: block.timestamp,
            packedDate: 0,
            shippedDate: 0,
            receivedDate: 0,
            ///// Exercise 3: set soldDate

            currentStage: Stage.Produced
        });

        // Log the initial stage
        emit ProductUpdated(productId, Stage.Produced);
    }

    // Function to update the product's packaging factory
    function updatePackagingFactory(
        bytes32 _productId,
        string memory _factory
    ) public {
        require(
            products[_productId].currentStage == Stage.Produced,
            "Product must be in Produced stage to update packaging factory."
        );

        products[_productId].factory = _factory;
        products[_productId].packedDate = block.timestamp;
        products[_productId].currentStage = Stage.Packed;

        // Log the stage change
        emit ProductUpdated(_productId, Stage.Packed);
    }

    // Function to update the product's shipping information
    function updateShipping(bytes32 _productId) public {
        require(
            products[_productId].currentStage == Stage.Packed,
            "Product must be in Packed stage to update shipping information."
        );

        products[_productId].shippedDate = block.timestamp;
        products[_productId].currentStage = Stage.Shipped;

        // Log the stage change
        emit ProductUpdated(_productId, Stage.Shipped);
    }

    // Function to update the product's retail store
    function updateRetailStore(bytes32 _productId, string memory _shop) public {
        require(
            products[_productId].currentStage == Stage.Shipped,
            "Product must be in Shipped stage to update retail store."
        );

        products[_productId].shop = _shop;
        products[_productId].receivedDate = block.timestamp;
        products[_productId].currentStage = Stage.Received;

        // Log the stage change
        emit ProductUpdated(_productId, Stage.Received);
    }

    ///// Exercise 4: declare updateSelling function with _productId parametter
    ///// require current stage must be Received state
    ///// set soldDate to block timestamp
    ///// set current state to be Sold

    // Function to get product details
    function getProductDetails(
        bytes32 _productId
    )
        public
        view
        returns (
            uint256 id,
            string memory name,
            string memory farmer,
            string memory factory,
            string memory shop,
            uint256 producedDate,
            uint256 packedDate,
            uint256 shippedDate,
            uint256 receivedDate,
            Stage currentStage
        )
    {
        Product storage product = products[_productId];

        return (
            product.id,
            product.name,
            product.farmer,
            product.factory,
            product.shop,
            product.producedDate,
            product.packedDate,
            product.shippedDate,
            product.receivedDate,
            product.currentStage
        );
    }
}
