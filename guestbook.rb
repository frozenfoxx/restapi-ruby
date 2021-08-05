require 'date'

# Handle all guestbook operations
class Guestbook:
    def initialize()
        @signatures = {}
    end

    # Add a signature to the book if not already signed
    def add(name_to_add)
        unless @signatures.key?(name_to_add)
            @signatures.store(name_to_add, Time.now)
        else
            raise RuntimeError "#{name_to_add} already signed on #{@signatures[name_to_add]}"
        end

        return "Successfully added #{name_to_add} at #{@signatures[name_to_add]}"
    end

    # Delete a signature from the book
    def delete(name_to_delete)
        if @signatures.key?(name_to_delete)
            @signatures.delete(name_to_delete)
        else
            raise RuntimeError "#{name_to_delete} is not in the book"
        end
        
        return "Successfully removed #{name_to_delete} at #{@signatures[name_to_delete]}"
    end

    # Update when a guest signed the book
    def update(name_to_update)
        if @signatures.key?(name_to_update)
            @signatures[name_to_update] = Time.now
        else
            raise RuntimeError "#{name_to_update} is not in the book"

        return "Successfully updated #{name_to_update} at #{@signatures[name_to_update]}"

    end

    attr_reader :signatures
end