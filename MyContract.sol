// ປະກາດ lincense ທີ່ໃຊ້
// SPDX-License-Identifier: MIT

// ປະກາດ version ຂອງ compiler
pragma solidity >=0.8.2 <0.9.0;

// ປະກາດຊື່ Smart Contract ໃຫ້ກົງກັບຊື່ຟາຍ
contract MyContract {
    // ປະກາດໂຕປ່ຽນແບບ state variable
    uint myData;

    // ຟັງຊັ້ນ setData ມີການຮັບຄ່າເຂົ້າໃນຟັງຊັ້ນຜ່ານ parameter
    // ເພື່ອບັນທຶກຄ່າເຂົ້າໃນ myData ເຊິ່ງຈະເສຍຄ່າ gas
    // ຈາກນັ້ນຄ່າທີ່ບັນທຶກນັ້ນຈະຖືກສົ່ງເຂົ້າໃນ Chain
    function setData(uint _data) public {
        // ສັ່ງບັນທຶກຄ່າ _data ເຂົ້າໃນ myData
        myData = _data;
    }

    // ຟັງຊັ້ນ getData ເປັນການເອີ້ນຂໍ້ມູນໃນ chain ອອກມາອ່ານ
    // ໃສ່ຄຳສັ່ງ view ແມ່ນເປັນການສະແດງຂໍ້ມູນ ຈະບໍ່ເສຍຄ່າ gas
    function getData() public view returns (uint) {
        return myData;
    }
}
