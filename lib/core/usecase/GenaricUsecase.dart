abstract class UseCase<Type,Params> {
  Future<Type> invoke({Params params});
}