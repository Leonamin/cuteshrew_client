import 'package:cuteshrew/core/domain/entity/comment_create_entity.dart';
import 'package:cuteshrew/presentation/data/comment_create_data.dart';
import 'package:cuteshrew/presentation/mappers/data_mapper.dart';

class CommentCreateDataMapper
    extends DataMapper<CommentCreateData, CommentCreateEntity> {
  @override
  CommentCreateEntity map(CommentCreateData object) {
    return CommentCreateEntity(comment: object.comment);
  }
}
