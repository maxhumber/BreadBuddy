import Core
import GRDB

extension Recipe: FetchableRecord, MutablePersistableRecord {
    public mutating func didInsert(with rowID: Int64, for column: String?) {
        self.id = rowID
    }
}
