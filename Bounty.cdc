import FungibleToken from 0x9a0766d93b6608b7

access(all) contract Bounty {
    // Events
    access(all) event BountyCreated(id: UInt64, creator: Address, amount: UFix64)
    access(all) event BountyClaimed(id: UInt64, claimer: Address)

    // Stored Properties
    access(all) var bounties: {UInt64: Bounty}
    access(all) var nextBountyId: UInt64

    // Bounty struct
    access(all) struct Bounty {
        access(all) let id: UInt64
        access(all) let creator: Address
        access(all) let amount: UFix64
        access(all) let deadline: UFix64
        access(all) var claimed: Bool

        init(id: UInt64, creator: Address, amount: UFix64, deadline: UFix64) {
            self.id = id
            self.creator = creator
            self.amount = amount
            self.deadline = deadline
            self.claimed = false
        }
    }

    init() {
        self.bounties = {}
        self.nextBountyId = 1
    }

    access(all) fun createBounty(amount: UFix64, deadline: UFix64) {
        let bounty = Bounty(
            id: self.nextBountyId,
            creator: self.account.address,
            amount: amount,
            deadline: deadline
        )
        
        self.bounties[self.nextBountyId] = bounty
        
        emit BountyCreated(id: self.nextBountyId, creator: self.account.address, amount: amount)
        
        self.nextBountyId = self.nextBountyId + 1
    }
}