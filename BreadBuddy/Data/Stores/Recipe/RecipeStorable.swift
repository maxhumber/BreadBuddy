import Core
import GRDB

extension Recipe: RecipeStorable {
    public mutating func didInsert(with rowID: Int64, for column: String?) {
        self.id = rowID
    }
}

protocol RecipeStorable: FetchableRecord, MutablePersistableRecord {}
