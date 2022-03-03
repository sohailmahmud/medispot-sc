pragma solidity ^0.8.12;

contract ChainMedispotContract {
    //standalones
    address buyer;
    address seller;

    //mappings
    mapping(address => address) buyerSellerMapping;

    //Supply Chain Stages
    enum Stages {
        RequestForMedicine,
        RequestApproved,
        Dispatched,
        Shipping,
        DeliveredToWareHouse,
        DeliveryComplete,
        Done
    }

    //Stage initalization
    Stages public stage;

    //modifiers
    modifier atStage(Stages _stage) {
        require(stage == _stage);
        _;
    }

    modifier transitionNext() {
        _;
        stage = Stages(uint256(stage) + 1);
    }

    modifier isSeller() {
        require(msg.sender == seller);
        _;
    }

    modifier isBuyer() {
        require(msg.sender == buyer);
        _;
    }

    //Return Stages
    function getStage() public view returns (string memory) {
        if (uint256(stage) == 0) {
            return ("RequestForMedicine");
        }
        if (uint256(stage) == 1) {
            return ("RequestApproved");
        }
        if (uint256(stage) == 2) {
            return ("Dispatched");
        }
        if (uint256(stage) == 3) {
            return ("Shipping");
        }
        if (uint256(stage) == 4) {
            return ("DeliveredToWareHouse");
        }
        if (uint256(stage) == 5) {
            return ("DeliveryComplete");
        }
        if (uint256(stage) == 6) {
            return ("Done");
        }
    }

    //Callable State Changes
    function requestForMedicine()
        public
        atStage(Stages.RequestForMedicine)
        isBuyer
        transitionNext
    {}

    function requestApproved()
        public
        atStage(Stages.RequestApproved)
        isSeller
        transitionNext
    {}

    function dispatched()
        public
        atStage(Stages.Dispatched)
        isSeller
        transitionNext
    {}

    function shipping()
        public
        atStage(Stages.Shipping)
        isSeller
        transitionNext
    {}

    function deliverToWarehouse()
        public
        atStage(Stages.DeliveredToWareHouse)
        isSeller
        transitionNext
    {}

    function complete()
        public
        atStage(Stages.DeliveryComplete)
        isBuyer
        transitionNext
    {}

    //Contract Intializer
    function start(address _seller) public {
        buyerSellerMapping[msg.sender] = _seller;
        buyer = msg.sender;
        seller = _seller;
    }
}
