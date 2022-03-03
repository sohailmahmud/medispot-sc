pragma solidity ^0.8.12;

contract MedispotContract {
    struct PatientStruct {
        uint256 patientID;
        string name;
        address patientAddress;
    }

    mapping(address => bytes32) patientDataHashMapping;
    mapping(address => mapping(uint256 => PatientStruct)) doctorPatientMapping;

    function getPatientAddressWithNumber(uint256 _patientNumber)
        public
        view
        returns (address)
    {
        return doctorPatientMapping[msg.sender][_patientNumber].patientAddress;
    }

    function getPatientNameWithNumber(uint256 _patientNumber)
        public
        view
        returns (address)
    {
        return doctorPatientMapping[msg.sender][_patientNumber].patientAddress;
    }

    function storePatientData(bytes memory _patientData) public {
        patientDataHashMapping[msg.sender] = keccak256(_patientData);
    }

    function getPatientData() public view returns (bytes32) {
        return patientDataHashMapping[msg.sender];
    }

    function addPatient(
        uint256 _patientID,
        string memory _patientName,
        address _patientAddress
    ) public {
        doctorPatientMapping[msg.sender][_patientID] = PatientStruct(
            _patientID,
            _patientName,
            _patientAddress
        );
    }
}
