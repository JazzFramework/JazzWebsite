import Foundation;

import Configuration;
import Server;
import ServerNio;

func GetInitializers() throws -> [String] {
    if let path = Bundle.module.path(forResource: "initializers", ofType: "txt") {
        let file = try String(contentsOfFile: path)

        let text: [String] = file.components(separatedBy: "\n");

        return text;
    }

    return [];
}

try AppRunner(
    withApp:
        try AppBuilder()
            .With(httpProcessor: HummingbirdHttpProcessor())
            .Build(),
    withInitializers:
        GetInitializers(),
    withConfiguration: 
        ConfigurationBuilder()
            .With(bundle: Bundle.module)
)
    .Run();