module publisher::Second {

    use aptos_framework::resource_account;
    use first::get_value;

    struct Value has key {
        val: u32
    }

    fun init_module(resource_signer: &signer) {
         let resource_signer_cap = resource_account::retrieve_resource_account_cap(resource_signer, @source_addr);
         move_to(resource_signer, Value {
             val: get_value()
         });
    }

    # [view]
    public fun get_value(): u32 {
        borrow_global<Value>(@publisher).val
    }
}
