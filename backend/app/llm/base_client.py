from abc import ABC, abstractmethod

'''
BaseLLMClient ist eine abstrakte Basisklasse, die die Schnittstelle für LLM-Clients definiert.
Sie besitzt eine einzelne abstrakte Methode namens *generate*, die einen Prompt als Eingabe erhält und einen String
als Ausgabe zurückgibt. Diese Klasse kann von spezifischen LLM-Client-Implementierungen wie *OpenAIClient* oder
*HuggingFaceClient* erweitert werden, um konkrete Implementierungen der *generate*-Methode bereitzustellen.
Durch die Verwendung einer abstrakten Basisklasse wird sichergestellt, dass alle LLM-Clients eine einheitliche
Schnittstelle einhalten, wodurch sich unterschiedliche LLM-Anbieter leichter in die Anwendung integrieren lassen.
'''
class BaseLLMClient(ABC):

    @abstractmethod
    def generate(self, prompt: str) -> str:
        pass
