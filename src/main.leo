// The 'wlsign' program.
program wlsign.aleo {
       // - 'is_vote' : The is_vote of tokens .
    record Token {
        owner: address,
        gates: u64,
        sign_address: address,
        is_sign: bool
    }

    record SignToken {
        owner: address,
        gates: u64,
        will_sign_num: u64,
        sign_num: u64
    }


    // An on-chain mapping, storing the amount of tokens owned by each account
    // The account is stored as a to preserve user privacy.
    mapping sign_nums: field => u64;
    mapping sign_addresss: field => u64;


    transition account(owner: address, sign_address:address) -> Token {
        assert_eq(self.caller, aleo1prh7sjyts3f9qhhmuz8lz0jc4a328dnvf2lrfmdx5v2lspljs5xq7kaxd8);
        return Token {
            owner: owner,
            gates: 0u64,
            sign_address: sign_address,
            is_sign: false,
        };
    }
  


    transition optionSign(owner: address,will_sign_num:u64,sign_num:u64) -> SignToken {
        assert_eq(self.caller, aleo1prh7sjyts3f9qhhmuz8lz0jc4a328dnvf2lrfmdx5v2lspljs5xq7kaxd8);
       
        let signx: SignToken = SignToken {
            owner: owner,
            gates: 0u64,
            will_sign_num:will_sign_num,
            sign_num: sign_num,
        };
        let hash: field = BHP256::hash_to_field(owner);
        return signx  then finalize (hash,will_sign_num,sign_num);
    }

    finalize optionSign(hash: field,will_sign_num:u64,sign_num:u64) {
        Mapping::set(sign_nums, hash, sign_num);
    }


    transition will_sign(token: Token, goods: SignToken) -> Token {
     assert_eq(token.sign_address, goods.owner);


        let remaining: Token = Token {
            owner: token.owner,
            gates: token.gates,
            sign_address:token.sign_address,
            is_sign: true,
        };

        let goodsx: SignToken = SignToken {
            owner: goods.owner,
            gates: 0u64,
            will_sign_num:goods.will_sign_num + 1u64,
            sign_num: goods.sign_num ,
        };
         let hash: field = BHP256::hash_to_field(goods.owner);
        return remaining then finalize (hash,goodsx.sign_num);
    }


    finalize will_sign(hash: field , sign_num: u64 ) {
        Mapping::set(sign_nums, hash, sign_num);
    }



    transition sign(token: Token, goods: SignToken) -> Token {
         assert_eq(token.sign_address, goods.owner);
      
      
        let remaining: Token = Token {
            owner: token.owner,
            gates: token.gates,
            sign_address:token.sign_address,
            is_sign: true,
        };

        let goodsx: SignToken = SignToken {
            owner: goods.owner,
            gates: 0u64,
            will_sign_num:goods.will_sign_num,
            sign_num: goods.sign_num + 1u64,
        };
        let hash: field = BHP256::hash_to_field(goodsx.owner);
        return remaining then finalize (hash,goodsx.sign_num);
    }



    finalize sign(hash: field , sign_num: u64 ) {
        Mapping::set(sign_nums, hash, sign_num);
    }

   
}
