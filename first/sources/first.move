module publisher::first {

    use aptos_framework::account::SignerCapability;
    use aptos_framework::resource_account;

    struct ExampleStruct has key{
        value: u32,
        signer_cap: SignerCapability
    }

    fun init_module(resource_signer: &signer){
        let resource_signer_cap = resource_account::retrieve_resource_account_cap(resource_signer, @source_addr);
        move_to(resource_signer, ExampleStruct {
            value: 25, 
            signer_cap: resource_signer_cap,
        });
    }

    public entry fun set_value(value: u32) acquires ExampleStruct {
        let example_struct = borrow_global_mut<ExampleStruct>(@publisher);
        example_struct.value = value;
    }

    # [view]
    public fun get_value(): u32 acquires ExampleStruct {
        let example_struct = borrow_global<ExampleStruct>(@publisher);
        example_struct.value
    }
}
