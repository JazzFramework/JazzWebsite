import WindmillDataAccess;

public class Weather: Storable {
    public var id: String;
    public let temp: String;

    public init(_ id: String, _ temp: String) {
        self.id = id;
        self.temp = temp;
    }

    public func getId() -> String {
        return id;
    }

    public func set(id: String) {
        self.id = id;
    }
}