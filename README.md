# sign_12xugaj.aleo


## Name
Anonym Meeting Registration (AMR)

## Summary
AMR is the right solution for attendees having demand on check-in at hotel or registration for meetings anonymously. 


## Application Values
1. AMR takes advantage of blockchain technology and Aleo functionality on zk-SNARKs.

2. AMR utilizes Aleo Wallet as payment method. 


## User Flow
-- Meeting moderator initiate a meeting registration pool.

-- Attendees login with Aleo Wallet address.

-- Attendees register the meeting.


## How to Build

To compile this Aleo program, run:
```bash
aleo build
```

## How to Run
```bash
leo run account 'address' 'sign_address'
```
Enter the check-in address, the wallet address of the participants, bind the check-in wallet to the check-in center, and return this information `Token`

```bash
leo run optionSign 'address' 'will_sign_num' 'sign_num'
```
Enter the check-in address, number of people to sign in, and actual number of people to sign in, initialize the number of people to sign in at the check-in center, and return this information `SignToken`

```bash
leo run will_sign 'Token' 'SignToken'
```
Enter the `Token` and `SignToken` returned above, and add the number of people required to sign in

```bash
leo run sign 'Token' 'SignToken'
```
Input `Token` and `SignToken`, successfully signed in


## Parameter Description
```bash
Token {
	owner: address,
	gates: u64,
	sign_address: address,
	is_sign: bool
}

SignToken {
	owner: address,
	gates: u64,
	will_sign_num: u64,
	sign_num: u64
}
```


`Token.owner` Wallet addresses of participants

`SignToken.owner` Sign-in address

`sign_address` Sign-in address

`is_sign` Check in or not

`will_sign_num` Number of people who should sign in

`sign_num` Actual attendance




