class StorePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end

    def create?
      user.present?
    end

    def update?
      user.present? && user == record.user
    end

    def destroy?
      user.present? && user == record.user
    end
  end
end
