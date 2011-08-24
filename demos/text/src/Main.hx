//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

import flambe.animation.Easing;
import flambe.asset.AssetPack;
import flambe.display.FillSprite;
import flambe.display.Font;
import flambe.display.TextSprite;
import flambe.display.Transform;
import flambe.Entity;
import flambe.System;

class Main
{
    public static function run ()
    {
        var bg = new Entity().add(new FillSprite(0xffffff, System.stageWidth, System.stageHeight));
        System.root.addChild(bg);

        var font = new Font(_pack, "myfont");
        var label = new Entity()
            .add(new TextSprite(font, "Go ahead, tap me"));

        var messages = [
            "You call that a tap?",
            "Ouch :(",
            "Missed me...",
            "(Your touch screen works)",
        ];
        var taps = 0;
        bg.get(FillSprite).mouseDown.connect(function (_) {
            var transform = label.get(Transform);
            var margin = 50;
            transform.x.animateTo(
                margin + (System.stageWidth - 2*margin)*Math.random(), 1000, Easing.linear);
            transform.y.animateTo(
                margin + (System.stageHeight - 2*margin)*Math.random(), 1000, Easing.linear);
            transform.rotation.animateTo(360*Math.random(), 1000, Easing.quadOut);
            label.get(TextSprite).text = messages[taps++ % messages.length];
        });

        System.root.addChild(label);
    }

    private static function main ()
    {
        System.init();

        var loader = System.loadAssetPack("bootstrap");
        loader.success.connect(function () {
            _pack = loader.pack;
            run();
        });
        loader.error.connect(function (message) {
            trace("Load error: " + message);
        });
        loader.start();
    }

    private static var _pack :AssetPack;
}